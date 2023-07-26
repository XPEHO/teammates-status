package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "team_mate", schema = "public")
public class TeammateModel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "team_mate_seq")
    @SequenceGenerator(name = "team_mate_seq", sequenceName = "team_mate_id_seq", allocationSize = 1)
    @Column(name = "team_mate_id")
    private int id;
    @Column(name = "team_mate_team_id")
    private int teamId;
    @Column(name = "team_mate_user_id")
    private int userId;

    @Column(name = "team_mate_actif_flag")
    private boolean actif;



    public TeammateModel(int teamId, int userId) {
        this.teamId = teamId;
        this.userId = userId;
        this.actif = true;
    }

    public TeammateModel() {
    }

    public TeammateModel(int id, int teamId, int userId) {
        this.id = id;
        this.teamId = teamId;
        this.userId = userId;
        this.actif = true;
    }
    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }
    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    //used for test servicesImpl for create and save methods
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeammateModel that = (TeammateModel) o;
        return id == that.id && teamId == that.teamId && userId == that.userId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, teamId, userId);
    }
}
