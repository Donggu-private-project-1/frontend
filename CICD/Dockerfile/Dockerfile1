# Nginx의 경량 버전인 Alpine 이미지를 사용
FROM nginx:alpine

# Jenkins에서 빌드된 결과물을 복사하여 Nginx 기본 HTML 디렉토리로 설정
COPY ./build /usr/share/nginx/html

EXPOSE 80

# Nginx가 포어그라운드에서 실행되도록 설정하여 Docker 컨테이너가 종료되지 않게
CMD ["nginx", "-g", "daemon off;"]