use fuels::prelude::{abigen, launch_provider_and_get_wallet};

abigen!(Script(
    name = "TestUfp32Div",
    abi = "src/fixed_point/ufp32_div_test/out/debug/ufp32_div_test-abi.json"
),);

mod success {

    use super::*;

    #[tokio::test]
    async fn runs_ufp32_div_test_script() {
        let path_to_bin = "src/fixed_point/ufp32_div_test/out/debug/ufp32_div_test.bin";

        let wallet = launch_provider_and_get_wallet().await;

        let instance = TestUfp32Div::new(wallet, path_to_bin);

        let _result = instance.main().call().await;
    }
}
