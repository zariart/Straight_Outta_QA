
DOCKER = docker
IMAGE_RF          = jfxs/robot-framework
IMAGE_SELENIUM_GC = selenium/standalone-chrome:3
IMAGE_SELENIUM_FF = selenium/standalone-firefox:3

## Tests
## -----
test-simple: ## Run robot framework simple tests
test-simple:
	mkdir -p reports
	@if [ -z ${container} ]; then \
		chmod 777 reports && \
		$(DOCKER) run -t --rm -v ${PWD}/tests:/tests:ro -v ${PWD}/files:/files:ro -v ${PWD}/reports:/reports ${IMAGE_RF} robot --exclude selenium --outputdir /reports -v RF_SENSITIVE_VARIABLE:sensitive_data -v TESTS_DIR:/tests -v SHELL_DIR:/files RF && \
		chmod 755 reports ; \
	else \
		robot --include simple --outputdir reports tests/RF ; \
	fi

test-selenium: ## Run Robot Framework tests. Argument browser=ff|gc
test-selenium:
	test -n "${browser}"  # Failed if browser parameter is not set
	 $(DOCKER) network create tests-network
	@if [ "${browser}" = "ff" ]; then \
	   $(DOCKER) run --rm -d -p 4444:4444 -v /dev/shm:/dev/shm --network=tests-network --name selenium ${IMAGE_SELENIUM_FF}; \
	else \
	   $(DOCKER) run --rm -d -p 4444:4444 -v /dev/shm:/dev/shm --network=tests-network --name selenium ${IMAGE_SELENIUM_GC}; \
	fi
	 while (! wget -T 2 -q -O /dev/null http://localhost:4444); do sleep 1; done
	 -$(DOCKER) run -t --rm -v ${PWD}/tests:/tests:ro -v ${PWD}/reports:/reports --network=tests-network ${IMAGE_RF} robot -v BROWSER:${browser} --include selenium --outputdir /reports RF
	 $(DOCKER) kill selenium
	 $(DOCKER) network rm tests-network

clean-test-selenium: ## Clean local test environment
clean-test-selenium:
	 -$(DOCKER) kill selenium
	 -$(DOCKER) network rm tests-network

.PHONY: checks tests-local clean-tests-local tests-remote

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help
