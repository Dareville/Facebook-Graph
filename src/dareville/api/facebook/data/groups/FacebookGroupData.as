package dareville.api.facebook.data.groups
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookGroupData</code> class is a value object representing  
	 * data from a group page.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookGroupData 
		extends FacebookIdentificationData
	{
		private var _owner : FacebookIdentificationData;
		
		private var _updated_time : Date;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookGroupData(data:Object=null)
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
			
			if( data.hasOwnProperty( "owner" ) )
			{
				_owner = new FacebookIdentificationData( data.owner );
			}
			
			if( data.hasOwnProperty( "updated_time" ) )
			{
				_updated_time = createDate( data.updated_time );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Description
		 *  
		 * @return String
		 */		
		public function get description():String
		{
			return data.description;
		}
		
		/**
		 * Link URL
		 * 
		 * @return String 
		 */		
		public function get link():String
		{
			return data.link;
		}
		
		/**
		 * Privacy settings for the group
		 * 
		 * @return String 
		 */		
		public function get privacy():String
		{
			return data.privacy;
		}
		
		/**
		 * User who is the owner of the group
		 * 
		 * @return FacebookIdentificationData
		 */		
		public function get owner():FacebookIdentificationData
		{
			return _owner;
		}

		/**
		 * Date the group was last updated
		 * 
		 * @return Date 
		 */		
		public function get updated_time():Date
		{
			return _updated_time;
		}
	}
}