package dareville.api.facebook.data.comments
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookCommentData</code> class is a value object 
	 * representing comment data.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookCommentData 
		extends FacebookIdentificationData
	{
		private var _from : FacebookIdentificationData;
		
		private var _created_time : Date;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookCommentData(data:Object=null)
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
			
			if( data.hasOwnProperty( "from" ) )
			{
				_from = new FacebookIdentificationData( data.from );
			}
			
			if( data.hasOwnProperty( "created_time" ) )
			{
				_created_time = createDate( data.created_time );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * User who created the comment
		 * 
		 * @return FacebookIdentificationData
		 */		
		public function get from():FacebookIdentificationData
		{
			return _from;
		}
		
		/**
		 * Date the comment was created
		 * 
		 * @return Date 
		 */		
		public function get created_time():Date
		{
			return _created_time;
		}
		
		/**
		 * Comment string
		 * 
		 * @return String 
		 */
		public function get message():String
		{
			return data.message;
		}
	}
}