# Makefile
# A7d

VER := 20.11.2
TAR_NAME := dpdk-${VER}.tar.xz
URL := https://fast.dpdk.org/rel/${TAR_NAME}
TEMP_DIR := web_source
SOURCE_DIR := dpdk-stable-${VER}
BUILD_TYPE := release
# BUILD_TYPE=debug
BUILD_DIR := build-${BUILD_TYPE}


.PHONY: install build source get clean
.DEFAULT_GOAL := build

${TEMP_DIR}:
	mkdir -p ${TEMP_DIR}

get: ${TEMP_DIR}/${TAR_NAME}
${TEMP_DIR}/${TAR_NAME}: ${TEMP_DIR}
	wget -O ${TEMP_DIR}/${TAR_NAME} ${URL}
	@echo "Downloaded: ${TEMP_DIR}/${TAR_NAME}"

source: ${TEMP_DIR}/${SOURCE_DIR}
${TEMP_DIR}/${SOURCE_DIR}: ${TEMP_DIR}/${TAR_NAME}
	mkdir -p ${TEMP_DIR}/${SOURCE_DIR}
	tar -xvf ${TEMP_DIR}/${TAR_NAME} --directory ${TEMP_DIR}
	@echo "Source DIR: ${TEMP_DIR}/${SOURCE_DIR}"

build: ${TEMP_DIR}/${SOURCE_DIR}/${BUILD_DIR}
${TEMP_DIR}/${SOURCE_DIR}/${BUILD_DIR}: ${TEMP_DIR}/${SOURCE_DIR}
	cd ${TEMP_DIR}/${SOURCE_DIR} && \
	meson -Dkernel_dir=/lib/modules/`uname -r` -Denable_kmods=true -Dexamples=all -DCONFIG_RTE_LIBRTE_PMD_PCAP=y -DCONFIG_RTE_LIBRTE_PMD_RING=y --buildtype=${BUILD_TYPE} ${BUILD_DIR} &&\
	ninja -C ${BUILD_DIR}
	@echo "Build DIR: ${TEMP_DIR}/${SOURCE_DIR}/${BUILD_DIR}"

install: build
	cd ${TEMP_DIR}/${SOURCE_DIR} && \
	ninja install -C ${BUILD_DIR}

clean:
	rm -rf ${TEMP_DIR}/${SOURCE_DIR}
	@echo "Cleaned: ${TEMP_DIR}/${SOURCE_DIR}"