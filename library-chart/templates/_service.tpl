{{- define "library-chart.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}
  labels:
    {{- include "library-chart.labels" . | indent 4 }}
spec:
  selector:
    {{- include "library-chart.labels" . | indent 4 }}
  type: {{ default "ClusterIP" .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      protocol: {{ .Values.service.protocol }}
      name: http
      {{- if and (eq "NodePort" .Values.service.type) .Values.service.nodePort }}
      nodePort: {{ .Values.service.nodePort }}
      {{- end }}
{{- end }}
