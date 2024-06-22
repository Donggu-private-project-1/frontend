# 1단계: 빌드 단계

# Node.js 14 버전을 사용하여 빌드 환경을 설정
FROM node:14 as build  

# 작업 디렉토리를 /app으로 설정 
WORKDIR /app

# ./react/package.json, ./react/package-lock.json 파일을 현재 작업 디렉토리 (/app)로 복사! package.json 및 package-lock.json 파일을 기반으로 프로젝트의 모든 종속성을 설치
COPY ./react/package.json ./react/package-lock.json ./
RUN npm install

# ./react 디렉토리의 모든 파일을 작업 디렉토리 (/app)로 복사하고 React 프로덕션 모드로 빌드해 /app/build 디렉토리에 생성
COPY ./react ./
RUN npm run build




# 2단계: 실행 단계

# Nginx의 경량 버전인 Alpine 이미지를 사용
FROM nginx:alpine

# /app/build 디렉토리를 Nginx 기본 HTML 디렉토리 (/usr/share/nginx/html)로 복사
COPY --from=build /app/build /usr/share/nginx/html

# 로컬의 nginx.conf 파일을 Nginx의 기본 설정 파일 경로 (/etc/nginx/conf.d/default.conf)로 복사
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Nginx가 포어그라운드에서 실행되도록 설정하여 Docker 컨테이너가 종료되지 않게
CMD ["nginx", "-g", "daemon off;"]