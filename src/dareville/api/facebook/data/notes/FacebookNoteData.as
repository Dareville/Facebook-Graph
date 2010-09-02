package dareville.api.facebook.data.notes
{
	import dareville.api.facebook.data.comments.FacebookCommentCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookPageData</code> class is a value object representing 
	 * data from a note.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookNoteData 
		extends FacebookIdentificationData
	{
		private var _created_time : Date;
		private var _updated_time : Date;
		
		private var _comments : FacebookCommentCollectionData;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookNoteData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Protected methods
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  Override
		//----------------------------------
		
		/**
		 * @private 
		 */		
		override protected function init():void
		{
			super.init();
			
			if( data.hasOwnProperty( "created_time" ) )
			{
				_created_time = createDate( data.created_time );
			}
			
			if( data.hasOwnProperty( "updated_time" ) )
			{
				_updated_time = createDate( data.updated_time );
			}
			
			_comments = new FacebookCommentCollectionData( data.comments );
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Subject
		 * 
		 * @return String 
		 */		
		public function get subject():String
		{
			return data.subject;
		}
		
		/**
		 * Message 
		 *  
		 * @return String
		 */		
		public function get message():String
		{
			return data.message;
		}
		
		/**
		 * Note icon
		 * 
		 * @return String 
		 */		
		public function get icon():String
		{
			return data.icon;
		}
		
		/**
		 * Time the album was created
		 *  
		 * @return Date
		 */		
		public function get created_time():Date
		{
			return _created_time;
		}
		
		/**
		 * Time the album was updated last
		 * 
		 * @return Date 
		 */		
		public function get updated_time():Date
		{
			return _updated_time;
		}
		
		/**
		 * Album comments
		 * 
		 * @return FacebookCommentCollectionData 
		 */		
		public function get comments():FacebookCommentCollectionData
		{
			return _comments;
		}
	}
}