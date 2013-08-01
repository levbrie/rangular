'use strict';
angular.module('postsApp', ['ngResource']).config([
  '$routeProvider',
  function (a) {
    a.when('/', {
      templateUrl: 'views/main.html',
      controller: 'MainCtrl'
    }).otherwise({ redirectTo: '/' });
  }
]), angular.module('postsApp').factory('Post', [
  '$resource',
  function (a) {
    return a('/api/posts/:postId');
  }
]), angular.module('postsApp').controller('MainCtrl', [
  '$scope',
  function (a) {
    a.posts = Post.query(), a.create = function (b, c) {
      Post.save({
        name: b,
        content: c
      }, function (b) {
        a.posts.push(b);
      });
    }, a.delete = function (b) {
      Post.delete({ postId: a.posts[b].id }, function () {
        a.posts.splice(b, 1);
      });
    };
  }
]);