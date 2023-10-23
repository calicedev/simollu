package com.simollu.UserService.oauth;

public interface OAuth2UserInfo {

  String getProviderId();

  String getProvider();

  String getEmail();

  String getNickname();

  String getProfileImage();
}
