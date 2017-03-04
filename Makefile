owner?=gitpages

#	.—————.
#	| All |
#	'—————'
release-all: release-static release-jekyll release-hugo
build-all: build-static build-jekyll build-hugo
push-all: push-static push-jekyll push-hugo
clean-all: clean-static clean-jekyll clean-hugo

#	.———————————————————————.
#	| Gitpages stack static |
#	'———————————————————————'
file_static?=Dockerfile_static
image_static?=static
version_static?=v1
full_image_static?=${owner}/${image_static}:${version_static}

release-static: clean-static build-static push-static clean-static

build-static:
	docker build --pull -f ${file_static} -t ${full_image_static} .

push-static:
	docker push ${full_image_static}

clean-static:
	docker rmi -f ${owner}/${image_static}:${version_static} | true

#	.———————————————————————.
#	| Gitpages stack jekyll |
#	'———————————————————————'
file_jekyll?=Dockerfile_jekyll
image_jekyll?=jekyll
version_jekyll?=v1
full_image_jekyll?=${owner}/${image_jekyll}:${version_jekyll}

release-jekyll: clean-jekyll build-jekyll push-jekyll clean-jekyll

build-jekyll:
	docker build --pull -f ${file_jekyll} -t ${full_image_jekyll} .

push-jekyll:
	docker push ${full_image_jekyll}

clean-jekyll:
	docker rmi -f ${owner}/${image_jekyll}:${version_jekyll} | true

#	.—————————————————————.
#	| Gitpages stack hugo |
#	'—————————————————————'
file_hugo?=Dockerfile_hugo
image_hugo?=hugo
version_hugo?=v1
full_image_hugo?=${owner}/${image_hugo}:${version_hugo}

release-hugo: clean-hugo build-hugo push-hugo clean-hugo

build-hugo:
	docker build --pull -f ${file_hugo} -t ${full_image_hugo} .

push-hugo:
	docker push ${full_image_hugo}

clean-hugo:
	docker rmi -f ${owner}/${image_hugo}:${version_hugo} | true
