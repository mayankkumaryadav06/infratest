import requests

instance_identity_url = "http://169.254.169.254/latest/meta-data/"
session = requests.Session()
r = requests.get(instance_identity_url)
print(r.text)

for content_name in r.text.split("\n"):
    instance_identity_url_comp = "http://169.254.169.254/latest/meta-data/"+content_name
    session = requests.Session()
    req = requests.get(instance_identity_url_comp)
    print(content_name+": " + req.text+"\n")