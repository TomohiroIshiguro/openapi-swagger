CURDIR = "$(shell pwd)"

help:
	cat ./README.md
	cat ./Makefile

viewer:
	# 仕様書を Web ブラウザで表示します。
	# 構築後は http://localhost:18080 にアクセスしてください
	make mock
	docker run --rm --name api-spec \
	  -e SWAGGER_JSON=/home/openapi.yaml \
	  -v ${CURDIR}/dest/openapi.yaml:/home/openapi.yaml:ro \
	  -p 18080:8080 \
	  swaggerapi/swagger-ui \
	  >/dev/null &

mock:
	# Mock を構築します。
	# 構築後は http://localhost:18000/(パス) にアクセスしてください
	make link
	docker run --rm --name api-mock \
	  -v ${CURDIR}/dest/openapi.yaml:/home/openapi.yaml:ro \
	  -p 18000:4010 \
	  stoplight/prism:3 \
	  mock -h 0.0.0.0 /home/openapi.yaml \
	  >/dev/null &

link:
	# src フォルダ内のファイル分割した yaml を結合します。
	docker run --rm \
	  -v ${CURDIR}/src/:/src/ \
	  -v ${CURDIR}/dest/:/dest/ \
	  jeanberu/swagger-cli \
	  sh -c "swagger-cli bundle -t yaml -o /dest/openapi.yaml /src/openapi.yaml"

editor:
	# (非推奨)
	# Web ブラウザで Swagger のエディタを使えます。しかし、ファイルを分割をしていると ref をロードできません。
	# 編集したら忘れずに手動で yaml をダウンロードして元のファイルを置き換えてください。
	# 構築後は http://localhost:18081 にアクセスしてください
	docker run --rm --name api-editor \
	  -e SWAGGER_FILE=/src/openapi.yaml \
	  -v ${CURDIR}/src/:/src/:ro \
	  -p 18081:8080 \
	  swaggerapi/swagger-editor

down:
  # Docker で構築したビューア、モックサーバを破棄する
	docker stop api-mock
	docker stop api-spec
