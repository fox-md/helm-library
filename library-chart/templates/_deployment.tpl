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
          image: {{ required "value 'container.image.name' is required" .Values.container.image.name }}:{{ required "value 'container.image.tag' is required" .Values.container.image.tag }}
          ports:
            {{- toYaml .Values.container.ports | nindent 10 }}
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
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchLabels:
                  {{- include "library-chart.labels" . | indent 20 }}
                topologyKey: "kubernetes.io/hostname"
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- if .Values.nodeName }}
      nodeName: {{ .Values.nodeName }}
      {{- end }}
{{- end }}
