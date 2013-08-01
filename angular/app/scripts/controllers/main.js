'use strict';

angular.module('postsApp')
.factory('Post', function ($resource) {
	return $resource('/api/posts/:postId');
});

angular.module('postsApp')
.controller('MainCtrl', function ($scope, Post) {

  $scope.posts = Post.query();
  $scope.create = function(name, content) {
  	Post.save({name: name, content: content}, function(post) {
  		$scope.posts.push(post);
  	});
  };

  $scope.delete = function(index) {
  	Post.delete({postId: $scope.posts[index].id}, function() {
  		$scope.posts.splice(index, 1);
  	});
  };
});
