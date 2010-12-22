package dareville.api.facebook.data.users
{
	import dareville.api.facebook.data.common.FacebookBaseData;
	import dareville.api.facebook.data.common.FacebookIdentificationCollectionData;
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookEducationData</code> class is a value object 
	 * representing data from a user who has specified their previous education.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookEducationData 
		extends FacebookBaseData
	{
		private var _school : FacebookIdentificationData;
		private var _year : FacebookIdentificationData;
		
		private var _with : FacebookIdentificationCollectionData;
		
		private var _concentration : Array;
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookEducationData(data:Object=null)
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
			
			if( data.hasOwnProperty( "school" ) )
			{
				_school = new FacebookIdentificationData( data.school );
			}
			
			if( data.hasOwnProperty( "concentration" ) )
			{
				_concentration = new Array();
				
				var concentration : Array = data.concentration;
				var concentration_len : int = concentration.length;
				for( var i : int = 0; i < concentration_len; i++ )
				{
					var concentration_vo : FacebookIdentificationData = new FacebookIdentificationData( concentration[i] );
					_concentration.push( concentration_vo );
				}
			}
			
			if( data.hasOwnProperty( "with" ) )
			{	
				_with = new FacebookIdentificationCollectionData( data["with"] );
			}
			
			if( data.hasOwnProperty( "year" ) )
			{
				_year = new FacebookIdentificationData( data.year );
			}
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * School
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get school():FacebookIdentificationData
		{
			return _school;
		}
		
		/**
		 * Year
		 * 
		 * @return FacebookIdentificationData 
		 */	
		public function get year():FacebookIdentificationData
		{
			return _year;
		}
		
		/**
		 * Concentration
		 * 
		 * @return Array 
		 */	
		public function get concentration():Array
		{
			return _concentration;
		}
		
		/**
		 * With. Property name changed to <code>workedWith</code> because
		 * <code>with</code> is a reserved ActionScript keyword.
		 * 
		 * @return String 
		 */	
		public function get workedWith():FacebookIdentificationCollectionData
		{
			return _with;
		}
	}
}