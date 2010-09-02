package dareville.api.facebook.data.applications
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookApplicationData</code> class is a value object 
	 * representing data from an application.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookApplicationData 
		extends FacebookIdentificationData
	{
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function FacebookApplicationData(data:Object=null)
		{
			super(data);
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
		 * Facebook link to the application
		 * 
		 * @return String 
		 */		
		public function get link():String
		{
			return data.link;
		}
		
		/**
		 * Category
		 * 
		 * @return String 
		 */		
		public function get category():String
		{
			return data.category;
		}
	}
}