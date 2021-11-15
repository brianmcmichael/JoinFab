# GemJoin Factory

A factory for deploying dss-gem-join contracts using the appropriate compiler version.

To standardize the MakerDAO MCD system, new GemJoin contracts have been deployed using the compiler and optimization settings used at launch, due to a high confidence in the compiled code.

The GemJoin (changelog: `JOIN_FAB`) factory allows a collateral onboarding developer to deploy a new GemJoin using only a seth call or metamask using an interface like etherscan. This, in conjunction with tools like `CALC_FAB` and `FLIP_FAB` allow for the deployment of necessary contracts for collateral onboarding without needing to target the correct commit and solc version.

This repository can deploy the standard `GemJoin` contract for ERC20-compliant tokens, as well as the `GemJoin[2-8]` and `AuthGemJoin` variants.

# Contracts

- Mainnet:  [0xf1738d22140783707ca71cb3746e0dc7bf2b0264](https://etherscan.io/address/0xf1738d22140783707ca71cb3746e0dc7bf2b0264#code)
- Goerli: [0x0aaA1E0f026c194E0F951a7763F9edc796c6eDeE](https://goerli.etherscan.io/address/0x0aaA1E0f026c194E0F951a7763F9edc796c6eDeE#code)

# Verifying

The created contracts will be deployed using `solc 0.5.12` with optimizations off. Sometimes etherscan will automatically verify a new contract, but it doesn't always work. To verify the code, copy the source file from the appropriate location and verify using solc 0.5.12. If the parameter arguments are not automatically populated in the UI, you will need to recreate them using a tool like https://abi.hashex.org/
