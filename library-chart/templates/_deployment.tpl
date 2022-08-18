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
          securityContext:
            {{- toYaml .Values.podSecurityContext | nindent 12 }}
          volumeMounts:
            {{- toYaml .Values.volumeMounts | nindent 10 }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
      volumes:
        {{- toYaml .Values.volumes | nindent 8 }}
      affinity:
        {{- with .Values.affinity }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                {{- include "library-chart.labels" . | indent 16 }}
            topologyKey: "kubernetes.io/hostname"
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- if .Values.nodeName }}
      nodeName: {{ .Values.nodeName }}
      {{- end }}
{{- end }}
