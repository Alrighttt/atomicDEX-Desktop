//
// Created by milerius on 07/01/2022.
//

//! Dependencies
#include <nlohmann/json.hpp>

//! Project Headers
#include "rpc.enable.bch.with.tokens.hpp"

namespace mm2::api
{
    void
    to_json(nlohmann::json& j, const slp_token_request& cfg)
    {
        j["ticker"] = cfg.ticker;
        if (cfg.required_confirmations.has_value())
        {
            j["required_confirmations"] = cfg.required_confirmations.value();
        }
    }

    void
    to_json(nlohmann::json& j, const enable_rpc_data& cfg)
    {
        j["servers"] = cfg.servers;
    }

    void
    to_json(nlohmann::json& j, const enable_mode& cfg)
    {
        j["rpc"] = cfg.rpc;
        j["rpc_data"] = cfg.rpc_data;
    }

    void
    to_json(nlohmann::json& j, const enable_bch_with_tokens_request& cfg)
    {
        nlohmann::json obj = nlohmann::json::object();
        obj["ticker"] = cfg.ticker;
        obj["bchd_urls"] = cfg.bchd_urls;
        obj["tx_history"] = cfg.tx_history;
        obj["allow_slp_unsafe_conf"] = cfg.allow_slp_unsafe_conf.value_or(false);
        obj["mode"] = cfg.mode;
        obj["slp_tokens_requests"] = cfg.slp_token_requests;
        if (cfg.required_confirmations.has_value()) {
            obj["required_confirmations"] = cfg.required_confirmations.value();
        }
        if (cfg.requires_notarization.has_value()) {
            obj["requires_notarization"] = cfg.requires_notarization.value();
        }
        if (cfg.address_format.has_value()) {
            obj["address_format"] = cfg.address_format.value();
        }
        if (cfg.utxo_merge_params.has_value()) {
            obj["utxo_merge_params"] = cfg.utxo_merge_params.value();
        }
        if (j.contains("mmrpc") && j.at("mmrpc").get<std::string>() == "2.0")
        {
            j["params"] = obj;
        }
    }
}