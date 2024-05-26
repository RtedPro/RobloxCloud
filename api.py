from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/deploy/android/roblox', methods=['GET'])
def deploy_android_roblox():
    try:
        # Run if triggered
        result = subprocess.run(['launcher.cmd'], capture_output=True, text=True, shell=True)
        
        # Check if any error
        if result.returncode == 0:
            # Send the captured output to the client
            return jsonify(message=result.stdout.strip()), 200
        else:
            # Send the error output to the client
            return jsonify(message=result.stderr.strip()), 500
    except Exception as e:
        return jsonify(message=str(e)), 500

if __name__ == '__main__':
    app.run(port=9782)
