import sys
import os
import requests

MOD_PORTAL_URL = "https://mods.factorio.com"
INIT_UPLOAD_URL = f"{MOD_PORTAL_URL}/api/v2/mods/init_publish"

apikey = os.getenv("MOD_UPLOAD_API_KEY")
modname = sys.argv[1]
filepath = sys.argv[2]

request_body = {"mod": modname}
request_headers = {"Authorization": f"Bearer {apikey}"}

response = requests.post(INIT_UPLOAD_URL, data=request_body, headers=request_headers)

if not response.ok:
    print(f"init_upload failed: {response.text}")
    sys.exit(1)

upload_url = response.json()["upload_url"]

with open(filepath, "rb") as f:
    request_body = {"file": f}
    response = requests.post(upload_url, files=request_body, data={"description": "# published via API"})

if not response.ok:
    print(f"upload failed: {response.text}")
    sys.exit(1)

print(f"upload successful: {response.text}")
