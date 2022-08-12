{{- define "library-chart.serviceaccount" -}}
{{- if .Values.serviceAccount.create | default true -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .Values.serviceAccount.name }}
  labels:
    {{- include "library-chart.labels" . | indent 4 }}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
