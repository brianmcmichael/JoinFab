all    :; dapp --use solc:0.5.12 build
clean  :; dapp clean
test   :; dapp --use solc:0.5.12 test
deploy :; make && dapp create Joinfab
