package dareville.api.facebook.data.users
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;

	/**
	 * The <code>FacebookUserData</code> class is a value object representing 
	 * data from a user.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookUserData
		extends FacebookIdentificationData
	{
		private var _hometown : FacebookIdentificationData;
		private var _location : FacebookIdentificationData;
		
		private var _work : Array;
		private var _education : Array;
		
		private var _significant_other : FacebookIdentificationData;
		
		private var _updated_time : Date;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 * 
		 * @param data
		 */
		public function FacebookUserData( data : Object )
		{
			super( data );
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
		override protected function init() : void
		{
			super.init();
			
			if( data.hasOwnProperty( "hometown" ) )
			{
				_hometown = new FacebookIdentificationData( data.hometown );
			}
			
			if( data.hasOwnProperty( "location" ) )
			{
				_location = new FacebookIdentificationData( data.location );
			}
			
			if( data.hasOwnProperty( "work" ) )
			{	
				_work = new Array();
				var work : Array = data.work;
				var work_len : int = work.length;
				for( var i : int = 0; i < work_len; i++ )
				{
					var work_vo : FacebookWorkData = new FacebookWorkData( work[i] );
					_work.push( work_vo );
				}
			}
			
			if( data.hasOwnProperty( "education" ) )
			{	
				_education = new Array();
				var education : Array = data.education;
				var education_len : int = education.length;
				for( i = 0; i < education_len; i++ )
				{
					var education_vo : FacebookEducationData = new FacebookEducationData( education[i] );
					_education.push( education_vo );
				}
			}
			
			if( data.hasOwnProperty( "significant_other" ) )
			{
				_significant_other = new FacebookIdentificationData( data.significant_other );
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
		 * First name
		 * 
		 * @return String 
		 */		
		public function get first_name():String
		{
			return data.first_name;
		}
		
		/**
		 * Last name
		 * 
		 * @return String 
		 */	
		public function get last_name():String
		{
			return data.last_name;
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
		 * About
		 * 
		 * @return String 
		 */	
		public function get about():String
		{
			return data.about;
		}
		
		/**
		 * Birthday
		 * 
		 * @return String 
		 */	
		public function get birthday():String
		{
			return data.birthday;
		}
		
		/**
		 * Array of <code>FacebookWorkData</code>
		 * 
		 * @return Array 
		 */	
		public function get work():Array
		{
			return _work;
		}
		
		/**
		 * Array of <code>FacebookEducationData</code>
		 * 
		 * @return String 
		 */	
		public function get education():Array
		{
			return _education;
		}
		
		/**
		 * Email
		 * 
		 * @return String 
		 */	
		public function get email():String
		{
			return data.email;
		}
		
		/**
		 * Website
		 * 
		 * @return String 
		 */	
		public function get website():String
		{
			return data.website;
		}
		
		/**
		 * Hometown
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get hometown():FacebookIdentificationData
		{
			return _hometown;
		}
		
		/**
		 * Location
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get location():FacebookIdentificationData
		{
			return _location;
		}
		
		/**
		 * Gender
		 * 
		 * @return String 
		 */	
		public function get gender():String
		{
			return data.gender;
		}
		
		/**
		 * Interested in
		 * 
		 * @return Array 
		 */	
		public function get interested_in():Array
		{
			return data.interested_in;
		}
		
		/**
		 * Meeting for
		 * 
		 * @return Array 
		 */	
		public function get meeting_for():Array
		{
			return data.meeting_for;
		}
		
		/**
		 * Relationship status
		 * 
		 * @return String 
		 */	
		public function get relationship_status():String
		{
			return data.relationship_status;
		}
		
		/**
		 * Religion
		 * 
		 * @return String 
		 */	
		public function get religion():String
		{
			return data.religion;
		}
		
		/**
		 * Political
		 * 
		 * @return String 
		 */	
		public function get political():String
		{
			return data.political;
		}
		
		/**
		 * Timezone
		 * 
		 * @return int 
		 */	
		public function get timezone():int
		{
			return data.timezone;
		}
		
		/**
		 * Locale
		 * 
		 * @return String 
		 */	
		public function get locale():String
		{
			return data.locale;
		}
		
		/**
		 * Verified
		 * 
		 * @return Boolean 
		 */	
		public function get verified():Boolean
		{
			return data.verified;
		}
		
		/**
		 * Date last updated
		 * 
		 * @return Date 
		 */	
		public function get updated_time():Date
		{
			return _updated_time;
		}
	}
}