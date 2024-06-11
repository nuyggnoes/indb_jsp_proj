package com.example.dto;

import java.io.Serializable;

public class StoreDTO implements Serializable {
    private int store_id;
    private String store_name;
    private String description;

    private String category;
    private String lng_n_lat;
    private String location;
    private String store_number;

    public int getStore_id() {
        return store_id;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public String getStore_name() {
        return store_name;
    }

    public void setStore_name(String store_name) {
        this.store_name = store_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStore_number() {
        return store_number;
    }

    public void setStore_number(String store_number) {
        this.store_number = store_number;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getLng_n_lat() {
        return lng_n_lat;
    }

    public void setLng_n_lat(String lng_n_lat) {
        this.lng_n_lat = lng_n_lat;
    }
}