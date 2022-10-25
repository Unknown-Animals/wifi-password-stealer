from lib import subprocess

for s in subprocess.run(["netsh", "wlan", "show", "profiles"], stdout=subprocess.PIPE).stdout.replace(b"\r", b"").split(b"\n"):
    if b"All User Profile" in s:
        ssid = s.split(b":")[1][1:].decode()
        c = subprocess.check_output(f'netsh wlan show profile name="{ssid}" key=clear').replace(b"\r", b"").split(b"\n")
        with open("../wifi-passwords.txt", "a") as f:
            for r in c:
                if b"Security key" in r and b"Present" in r:
                    o = f"{ssid}: {c[c.index(r)+1].split(b':')[1][1:].decode()}\n"
                    print(o)
                    f.write(o)

input("(paused) Enter to continue...")
