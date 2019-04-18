# TradeByte CI System

## Intorduction
This is bare minimum build and deploymemnt system which can be integrated with Jenkins/ circle ci and etc . This is a concept


##How it works

This CI system designed keep in mind  for multiple developer and there different branch.

####Build 
bash  build_script.sh <git branch > <exposed_port_for_application>
bash build_script.sh master 8000

╰─$ bash build_script.sh master 8000
Running  Test  Cases
...
----------------------------------------------------------------------
Ran 3 tests in 0.000s

OK
Building Container------------------
Sending build context to Docker daemon   85.5kB
Step 1/8 : FROM python:3.7-alpine3.8
 ---> 283c260b5305
Step 2/8 : ARG  EXPOSE_PORT
 ---> Using cache
 ---> b5e645b1a2e7
Step 3/8 : RUN mkdir /srv/app
 ---> Using cache
 ---> 9afaac61fad8
Step 4/8 : COPY . /srv/app
 ---> e30c2c015ff6
Step 5/8 : WORKDIR /srv/app
 ---> Running in 2da432d369f6
Removing intermediate container 2da432d369f6
 ---> 6bc06c3bf6f3
Step 6/8 : RUN  pip install -r requirements.txt
 ---> Running in 99c3915a010b
Collecting redis==3.2.1 (from -r requirements.txt (line 1))
  Downloading https://files.pythonhosted.org/packages/ac/a7/cff10cc5f1180834a3ed564d148fb4329c989cbb1f2e196fc9a10fa07072/redis-3.2.1-py2.py3-none-any.whl (65kB)
Collecting tornado==5.1.1 (from -r requirements.txt (line 2))
  Downloading https://files.pythonhosted.org/packages/e6/78/6e7b5af12c12bdf38ca9bfe863fcaf53dc10430a312d0324e76c1e5ca426/tornado-5.1.1.tar.gz (516kB)
Building wheels for collected packages: tornado
  Building wheel for tornado (setup.py): started
  Building wheel for tornado (setup.py): finished with status 'done'
  Stored in directory: /root/.cache/pip/wheels/6d/e1/ce/f4ee2fa420cc6b940123c64992b81047816d0a9fad6b879325
Successfully built tornado
Installing collected packages: redis, tornado
Successfully installed redis-3.2.1 tornado-5.1.1
Removing intermediate container 99c3915a010b
 ---> b5d4e0a88b59
Step 7/8 : EXPOSE 8000
 ---> Running in 7c69cfac8929
Removing intermediate container 7c69cfac8929
 ---> 0ad51bb3ea97
Step 8/8 : CMD ["python", "hello.py"]
 ---> Running in b544e845872f
Removing intermediate container b544e845872f
 ---> 1aa25102c557
Successfully built 1aa25102c557
Successfully tagged apps:latest
docker push bpain2010/apps:tradebyte-master-d2cac56b1f4573fc5bd7b7a31b4167ba44a68395
Pushing container to registry----------
The push refers to repository [docker.io/bpain2010/apps]
b8b7fce19492: Pushed 
a974fef7b610: Pushed 
abddedf9e7f7: Layer already exists 
58dc85ebcb7e: Layer already exists 
af455f8d4714: Layer already exists 
8cc80861cf3a: Layer already exists 
9797041513df: Layer already exists 
d9ff549177a9: Layer already exists 
tradebyte-master-d2cac56b1f4573fc5bd7b7a31b4167ba44a68395: digest: sha256:55a194c1d3f71abc198962ecb0a70c8010fa6e17b3309f8f2c871d7ed825055a size: 1995


container imgae 
<repository><git-branch><git-hash>
bpain2010/apps:tradebyte-master-d2cac56b1f4573fc5bd7b7a31b4167ba44a68395

####Deploy

Here Ansible has been used to deploy project in the developement environemnt.  Here as per different branch we have different appplication running.

ansible-playbook  -i hosts  playbook.yml  --private-key=~/Downloads/introday-candidate_2019-04-18.pem -u ubuntu  -e "image_name=bpain2010/apps:tradebyte-master-d2cac56b1f4573fc5bd7b7a31b4167ba44a68395" -e "apps_name=hellob" -e "apps_ports=8000" -e "published_port=8000"

