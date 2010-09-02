package dareville.api.facebook.data.feed
{
	/**
	 * The <code>FacebookFeedCreatePostData</code> value object class provides 
	 * data related to posting something on user/application/group/page/etc wall
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookFeedCreatePostData
	{
		private var _message : String;
		private var _picture : String;
		private var _link : String;
		private var _name : String;
		private var _caption : String;
		private var _description : String;
		private var _source : String;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param message The message
		 * @param link The link attached to this post
		 * @param picture If available, a link to the picture included with this post
		 * @param name The name of the link
		 * @param caption The caption of the link (appears beneath the link name)
		 * @param description A description of the link (appears beneath the link caption)
		 * @param source If available, the source link attached to this post (for example, a flash or video file)
		 */		
		public function FacebookFeedCreatePostData( 
			message : String, 
			link : String = null, 
			picture : String = null, 
			name : String = null, 
			caption : String = null, 
			description : String = null, 
			source : String = null  )
		{
			_message = message;
			_picture = picture;
			_link = link;
			_name = name;
			_caption = caption;
			_description = description;
			_source = source;
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * The message
		 *  
		 * @return String
		 */		
		public function get message():String
		{
			return _message;
		}

		/**
		 * If available, a link to the picture included with this post
		 *  
		 * @return String
		 */	
		public function get picture():String
		{
			return _picture;
		}
		
		/**
		 * The link attached to this post
		 *  
		 * @return String
		 */	
		public function get link():String
		{
			return _link;
		}
		
		/**
		 * The name of the link
		 *  
		 * @return String
		 */	
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * The caption of the link (appears beneath the link name)
		 *  
		 * @return String
		 */	
		public function get caption():String
		{
			return _caption;
		}
		
		/**
		 * A description of the link (appears beneath the link caption)
		 *  
		 * @return String
		 */	
		public function get description():String
		{
			return _description;
		}
		
		/**
		 * If available, the source link attached to this post (for example, a 
		 * flash or video file)
		 *  
		 * @return String
		 */	
		public function get source():String
		{
			return _source;
		}
	}
}