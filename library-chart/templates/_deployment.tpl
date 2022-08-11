{{- define "library-chart.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}
  labels:
    {{- include "library-chart.labels" . | indent 4 }}
spec:
  replicas: {{ default 1 .Values.replicas }}
  selector:
    matchLabels:
      {{- include "library-chart.labels" . | indent 6 }}
  template:
    metadata:
      labels:
        {{- include "library-chart.labels" . | indent 8 }}
    spec:
      containers:
        - name: {{ .Release.Name }}
          image: {{ required "value 'image.name' is required" .Values.image.name }}:{{ required "value 'image.tag' is required" .Values.image.tag }}
{{- end }}
