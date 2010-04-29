require 'net/http'
require 'uri'
require 'digest/md5'
module Vkontakte
  API_METHODS = %w{ isAppUser getProfiles getFriends getAppFriends getUserBalance getUserSettings getGroups
                    getGroupsFull getCities getCountries photos_getAlbums photos_createAlbum photos_getUploadServer
                    photos_save }
end