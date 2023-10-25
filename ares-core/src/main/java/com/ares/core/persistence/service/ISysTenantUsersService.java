/*
 *
 *  * ****************************************************************************
 *  * * Copyright (c) 2021 - 9999, ARES
 *  * *
 *  * * Licensed under the Apache License, Version 2.0 (the "License");
 *  * * you may not use this file except in compliance with the License.
 *  * * You may obtain a copy of the License at
 *  * *
 *  * *        http://www.apache.org/licenses/LICENSE-2.0
 *  * *
 *  * * Unless required by applicable law or agreed to in writing, software
 *  * * distributed under the License is distributed on an "AS IS" BASIS,
 *  * * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * * See the License for the specific language governing permissions and
 *  * * limitations under the License.
 *  * ***************************************************************************
 *
 */

package com.ares.core.persistence.service;


import com.ares.core.model.query.SysTenantUsersQuery;
import com.ares.core.persistence.entity.SysTenantUsers;

import java.util.List;

public interface ISysTenantUsersService extends IBaseService<SysTenantUsers, SysTenantUsersQuery> {
    List<String> getUserIdsByTenant(Long tenantId);

    void delByTenantId(Long tenantId);

    Long getTenantIdByUserId(Long userId);
}
