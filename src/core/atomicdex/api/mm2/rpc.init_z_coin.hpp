/******************************************************************************
 * Copyright © 2013-2022 The Komodo Platform Developers.                      *
 *                                                                            *
 * See the AUTHORS, DEVELOPER-AGREEMENT and LICENSE files at                  *
 * the top-level directory of this distribution for the individual copyright  *
 * holder information and the developer policies on copyright and licensing.  *
 *                                                                            *
 * Unless otherwise agreed in a custom licensing agreement, no part of the    *
 * Komodo Platform software, including this file may be copied, modified,     *
 * propagated or distributed except according to the terms contained in the   *
 * LICENSE file                                                               *
 *                                                                            *
 * Removal or modification of this copyright notice is prohibited.            *
 *                                                                            *
 ******************************************************************************/

#pragma once

// Std Headers
#include <string>

// Deps Headers
#include <nlohmann/json_fwd.hpp>

namespace atomic_dex::mm2
{
    struct init_z_coin
    {
        static constexpr auto endpoint = "init_z_coin";
        static constexpr bool is_v2    = true;
        struct expected_request_type
        {

        } request;
        struct expected_answer_type
        {
            std::string task_id;
        } answer;
    };
    using init_z_coin_request = init_z_coin::expected_request_type;
    using init_z_coin_answer = init_z_coin::expected_answer_type;

    inline void to_json([[maybe_unused]] nlohmann::json& j, const init_z_coin_request&) { }
    void from_json(const nlohmann::json& json, init_z_coin_answer& in);
}