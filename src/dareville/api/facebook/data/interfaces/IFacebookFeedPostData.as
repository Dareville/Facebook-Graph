package dareville.api.facebook.data.interfaces
{
	import dareville.api.facebook.data.common.FacebookActionCollectionData;
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	import dareville.api.facebook.data.common.FacebookPrivacyData;

	/**
	 * The <code>IFacebookFeedPostData</code> interface defines value objects 
	 * representing post data on a page feed.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public interface IFacebookFeedPostData
		extends IFacebookIdentificationData
	{
		/**
		 * User that posted
		 * 
		 * @return FacebookIdentificationData 
		 */	
		function get from():FacebookIdentificationData;
		
		/**
		 * Users who the post was directed towards
		 *  
		 * @return FacebookIdentificationCollectionData
		 */
		function get to():FacebookIdentificationCollectionData;
		
		/**
		 * Time the post was created
		 * 
		 * @return Date 
		 */	
		function get created_time():Date;
		
		/**
		 * Time the post was updated
		 * 
		 * @return Date 
		 */	
		function get updated_time():Date;
		
		/**
		 * Post message
		 * 
		 * @return String 
		 */		
		function get message():String;
		
		/**
		 * Post type
		 * 
		 * @return String 
		 */		
		function get type():String;
		
		/**
		 * Post likes
		 * 
		 * @return int 
		 */		
		function get likes():int;
		
		/**
		 * Comments on the post
		 *  
		 * @return FacebookCommentCollectionData
		 */	
		function get comments():FacebookCommentCollectionData;
		
		/**
		 * Actions available on the post
		 *  
		 * @return FacebookActionCollectionData
		 */		
		function get actions():FacebookActionCollectionData;
		
		/**
		 * Privacy settings on this post
		 * 
		 * @return FacebookPrivacyData
		 */	
		function get privacy():FacebookPrivacyData;
	}
}