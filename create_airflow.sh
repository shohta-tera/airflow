# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update

# Create configmap for python requirements
kubectl create configmap airflow-python-requirements \
  -n jobs \
  --from-file=./files/config/requirements.txt \
  && kubectl apply -f -

sleep 10;

helm upgrade airflow bitnami/airflow \
  --install \
  --namespace jobs \
  --values=./values.yaml \
  --values=./secrets/secrets.yaml \
  --set externalDatabase.password=su_airflow \
  --set web.image.tag=2.0.2-debian-10-r4 \
  --set scheduler.image.tag=2.0.2-debian-10-r13 \
  --set worker.image.tag=2.0.2-debian-10-r13 \
  --set metrics.image.tag=0.20210126.0-debian-10-r93 \
  --version 10.0.1