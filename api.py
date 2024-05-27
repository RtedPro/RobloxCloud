from flask import Flask, jsonify
import subprocess
import time
import psutil
import re

app = Flask(__name__)

@app.route('/deploy/android/roblox', methods=['GET'])
def deploy_android_roblox():
    try:
        # Start vmmanager.cmd in a new CMD window
        subprocess.Popen(['cmd.exe', '/c', 'start', '/wait', 'cmd.exe', '/c', 'launcher.cmd'], 
                         shell=True)
        
        # Wait for up to 2:05 minutes, checks every 5 seconds.
        for _ in range(25):
            time.sleep(5)
            
            # Check if finished vncserver "Roblox-%name%"
            for proc in psutil.process_iter(['name', 'cmdline']):
                try:
                    if 'cmd.exe' in proc.info['name']:
                        for arg in proc.info['cmdline']:
                            match = re.search(r'Roblox-(\d+)', arg)
                            if match:
                                vncport = match.group(1)
                                ip = '127.0.0.1'
                                return jsonify(ip=ip, vnc_port=vncport), 200
                except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                    pass

        # If didn't appear, show a error
        return jsonify(message="Unexpected error has accured"), 500
    except Exception as e:
        return jsonify(message=str(e)), 500

if __name__ == '__main__':
    app.run(port=9782)
