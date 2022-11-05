#include <nlohmann/json.hpp>

#include "enable_eth_with_tokens_rpc.hpp"

namespace atomic_dex::mm2
{
    void to_json(nlohmann::json& j, const enable_eth_with_tokens_request_rpc& in)
    {
        j["ticker"] = in.ticker;
        j["tx_history"] = in.tx_history;
        j["erc20_tokens_requests"] = in.erc20_tokens_requests;
        j["swap_contract_address"]  = in.ticker != "ETH" ? in.erc_testnet_swap_contract_address : in.erc_swap_contract_address;
        j["fallback_swap_contract"] = in.ticker != "ETH" ? in.erc_testnet_fallback_swap_contract_address : in.erc_fallback_swap_contract_address;
        if (in.required_confirmations.has_value())
            j["required_confirmations"] = in.required_confirmations.value();
        if (in.requires_notarization.has_value())
            j["requires_notarization"] = in.requires_notarization.value();
        if (in.utxo_merge_params.has_value())
            j["utxo_merge_params"] = in.utxo_merge_params.value();
    }
    
    void to_json(nlohmann::json& j, const enable_eth_with_tokens_request_rpc::erc20_token_request_t& in)
    {
        j["ticker"] = in.ticker;
        if (in.required_confirmations)
            j["required_confirmations"] = in.required_confirmations.value();
    }
    
    void to_json(nlohmann::json& j, const enable_eth_with_tokens_request_rpc::utxo_merge_params_t& in)
    {
        j["merge_at"] = in.merge_at;
        j["check_every"] = in.check_every;
        j["max_merge_at_once"] = in.max_merge_at_once;
    }

    void from_json(const nlohmann::json& json, enable_eth_with_tokens_result_rpc& out)
    {
        out.current_block = json["current_block"];
        out.eth_addresses_infos = json["eth_addresses_infos"].get<typeof(out.eth_addresses_infos)>();
        out.erc20_addresses_infos = json["erc20_addresses_infos"].get<typeof(out.erc20_addresses_infos)>();
    }
    
    void from_json(const nlohmann::json& json, enable_eth_with_tokens_result_rpc::derivation_method_t& out)
    {
        out.type = json["type"];
    }
    
    void from_json(const nlohmann::json& json, enable_eth_with_tokens_result_rpc::eth_address_infos_t& out)
    {
        out.derivation_method = json["derivation_method"];
        out.pubkey = json["pubkey"];
        out.balances = json["balances"];
    }
    
    void from_json(const nlohmann::json& json, enable_eth_with_tokens_result_rpc::erc20_address_infos_t& out)
    {
        out.derivation_method = json["derivation_method"];
        out.pubkey = json["pubkey"];
        out.balances = json["balances"].get<typeof(out.balances)>();
    }
}