all     :; dapp --use solc:0.5.12 build
clean   :; dapp clean
test    :; make && dapp --use solc:0.5.12 test -v
flatten :; make && hevm flatten --source-file "src/JoinFab.sol" > out/flat.sol
deploy  :; make && dapp create Joinfab
