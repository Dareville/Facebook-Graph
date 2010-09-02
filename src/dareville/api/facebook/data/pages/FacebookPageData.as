package dareville.api.facebook.data.pages
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookPageData</code> class is a value object representing 
	 * data from a page.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookPageData 
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
		public function FacebookPageData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		/**
		 * Picture URL
		 * 
		 * @return String
		 */		
		public function get picture():String
		{
			return data.picture;
		}
		
		/**
		* Link
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
		
		/**
		 * User name
		 * 
		 * @return String
		 */	
		public function get username():String
		{
			return data.username;
		}
		
		/**
		 * Date founded
		 * 
		 * @return String
		 */	
		public function get founded():String
		{
			return data.founded;
		}
		
		/**
		 * Company overview
		 * 
		 * @return String
		 */	
		public function get company_overview():String
		{
			return data.company_overview;
		}
		
		/**
		 * Mission
		 * 
		 * @return String
		 */	
		public function get mission():String
		{
			return data.mission;
		}
		
		/**
		 * Products
		 * 
		 * @return String
		 */	
		public function get products():String
		{
			return data.products;
		}
		
		/**
		 * Number of fans
		 * 
		 * @return String
		 */	
		public function get fan_count():int
		{
			return data.fan_count;
		}
	}
}