(function() {
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[0].label="概览"
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[1].label="应用"
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[2].label="构建"
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[3].label="资源"
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[4].label="存储"
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[5].label="监控"
	window.OPENSHIFT_CONSTANTS.PROJECT_NAVIGATION[6].label="商店"
	window.OPENSHIFT_CONSTANTS.APP_LAUNCHER_NAVIGATION = [
	{
	  title: "Sharing Videos",
	  iconClass: "fa fa-video-camera",
	  href: "https://yun.baidu.com/s/1xIwYILHQebEHZOcW4yvsAw",
	  tooltip: "一键部署Openshift相关视频"
	}];

	var category = _.find(window.OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES,
                      { id: 'databases' });
	// Add Go as a new subcategory under Languages.
	category.subCategories.splice(2,0,{ // Insert at the third spot.
	  // Required. Must be unique.
	  id: "redis",
	  // Required.
	  label: "redis",
	  // Optional. If specified, defines a unique icon for this item.
	  icon: "icon-redis",
	  // Required. Items matching any tag will appear in this subcategory.
	  tags: [
	    "redis"
	  ]
	});

	window.OPENSHIFT_CONSTANTS.SERVICE_CATALOG_CATEGORIES.push({
	  // Required. Must be unique.
	  id: "messages",
	  // Required
	  label: "MQ",
	  subCategories: [
	    {
	      // Required. Must be unique.
	      id: "Messages",
	      // Required.
	      label: "MQ",
	      // Optional. If specified, defines a unique icon for this item.
	      icon: "icon-rabbitmq",
	      // Required. Items matching any tag will appear in this subcategory.
	      tags: [
	        "messaging"
	      ]
	    }
	  ]
	});

}());