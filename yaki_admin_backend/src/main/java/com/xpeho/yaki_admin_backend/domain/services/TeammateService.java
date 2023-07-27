package com.xpeho.yaki_admin_backend.domain.services;

import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateDetailsEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;

import java.util.List;

public interface TeammateService {

    TeammateEntity createTeammate(TeammateEntity teammateEntity);

    TeammateEntity getTeammate(int id);

    TeammateEntity deleteById(int id);

    TeammateEntity disabled(int id);

    TeammateEntity saveOrUpdate(TeammateEntity entity, int id);

    List<TeammateDetailsEntity> findAllByTeam(int id);
}
