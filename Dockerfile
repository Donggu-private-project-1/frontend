# 기반 이미지로부터 시작
FROM nginx:latest

# 컨테이너 내부의 /usr/share/nginx/html 디렉토리로 index.html 복사
COPY index.html /usr/share/nginx/html/

# 포트 80을 노출하여 HTTP 트래픽 허용
EXPOSE 80

# 컨테이너 시작 시 NGINX 실행
CMD ["nginx", "-g", "daemon off;"]