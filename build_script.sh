### Tradebyte build env
if [ "$1" == "help" ]; then
echo " Provide  git brach name  in 1st argument and  application port in 2nd argument"
exit 0
fi


if ([ -z $1 ] && [ -z $2 ] );  then
echo "No arhument supplied"
exit 0
fi

if [ -z $1 ]; then
        echo "Parameter 1 is empty"
        exit 0

fi
if [ -z $2 ]; then
        echo "Parameter 2 is empty"
        exit 0

fi

echo "Check out to branch"

git checkout ${1}
if [ "$?" -ne "0" ] ; then
echo "Provided branch is not available"
exit 0
fi

echo "Running  Test  Cases"
python  tests/test.py

if [ "$?" -ne "0" ] ; then
echo "Test cases are failing -- Abort"
exit 0
fi

echo "Building Container------------------"
GITHASH=`git rev-parse ${1}`
IMAGE_NAME=tradebyte-${1}-$GITHASH
docker build -t apps --build-arg EXPOSE_PORT=${2} .
docker tag apps:latest  apps:$IMAGE_NAME

docker tag apps:latest bpain2010/apps:${IMAGE_NAME}

echo docker push  bpain2010/apps:${IMAGE_NAME}
echo "Pushing container to registry----------"
docker push  bpain2010/apps:${IMAGE_NAME}
