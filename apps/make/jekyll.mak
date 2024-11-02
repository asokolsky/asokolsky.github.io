default: help

all: install build

h help:
	@grep '^[a-z]' Makefile

install:
	bundle config set --local path vendor/bundle
	bundle install

upgrade:			# update `Gemfile.lock`
	bundle update


s serve:			# launch locally
	bundle exec jekyll serve --trace --livereload

build:
	JEKYLL_ENV=production bundle exec jekyll build --trace

clean:
	rm -rf _site .bundle .jekyll-cache vendor
