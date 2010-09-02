package dareville.api.facebook.data.likes
{
	import dareville.api.facebook.data.common.FacebookIdentificationData;
	
	/**
	 * The <code>FacebookLikeData</code> class provides access to like 
	 * information on a specific post.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0.124
	 * 
	 * @author kris@dareville.com
	 */
	public class FacebookLikeData 
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
		public function FacebookLikeData(data:Object=null)
		{
			super(data);
		}
		
		//---------------------------------------------------------------------
		//
		//  Getter/Setter methods
		//
		//---------------------------------------------------------------------
		
		public function get category():String
		{
			return data.category;
		}
	}
}