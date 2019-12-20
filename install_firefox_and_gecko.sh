#!/bin/bash
# Use the Unbranded build that corresponds to a specific Firefox version (source: https://wiki.mozilla.org/Add-ons/Extension_Signing#Unbranded_Builds)
UNBRANDED_FF71_RELEASE_LINUX_BUILD="https://firefox-ci-tc.services.mozilla.com/api/queue/v1/task/QKKKcc7VQhq8ngUotlj6hA/runs/0/artifacts/public/build/target.tar.bz2"
wget "$UNBRANDED_FF71_RELEASE_LINUX_BUILD"
tar jxf target.tar.bz2
rm -rf firefox-bin
mv firefox firefox-bin
rm target.tar.bz2

# Selenium 3.3+ requires a 'geckodriver' helper executable, which is not yet
# packaged.
GECKODRIVER_VERSION=0.26.0
case $(uname -m) in
    (x86_64)
        GECKODRIVER_ARCH=linux64
        ;;
    (*)
        echo Platform $(uname -m) not known to be supported by geckodriver >&2
        exit 1
        ;;
esac
wget https://github.com/mozilla/geckodriver/releases/download/v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-${GECKODRIVER_ARCH}.tar.gz
tar zxf geckodriver-v${GECKODRIVER_VERSION}-${GECKODRIVER_ARCH}.tar.gz
rm geckodriver-v${GECKODRIVER_VERSION}-${GECKODRIVER_ARCH}.tar.gz
mv geckodriver firefox-bin
