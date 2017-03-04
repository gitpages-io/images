owner?=gitpages

#	.—————.
#	| All |
#	'—————'
release-all: release-jekyll release-hugo
build-all: build-jekyll build-hugo
push-all: push-jekyll push-hugo
clean-all: clean-jekyll clean-hugo

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
