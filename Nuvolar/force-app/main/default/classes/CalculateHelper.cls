/**************************************************************************
 * @author Company X
 * @Description  : Evaluates numerous flight-related calculations.
 * ========================================================================
 * @History
 * ------------------------------------------------------------------------
 * VERSION     AUTHOR                    DATE         DETAIL
    1.0      Jason Simmons           30/03/2023   Initial implementation  
 **************************************************************************/
public with sharing class CalculateHelper {
    
    
    public CalculateHelper() {}

    /**
     * This method will calculate the distance between two airports 
     * 
     * @param Decimal latitude1 - Departure air port latitude value
     * @param Decimal longitude1 - Departure air port longitude value
     * @param Decimal latitude2 - Arrival air port latitude value
     * @param Decimal longitude2 - Arrival air port longitude value
     * @return Decimal
     * @author Nuvolar
     */
    public static Decimal calculateDistance(Decimal latitude1, Decimal longitude1, Decimal latitude2, Decimal longitude2) {

        Integer earthRadius = 6371 * 1000; // in meters

        // Transform coordinates from degrees to radians
        Decimal latitudeRadians1 = latitude1 * Math.PI/180;
        Decimal latitudeRadians2 = latitude2 * Math.PI/180;

        // Latitude and longitude differences in radians
        Decimal latitudeDelta = (latitude2 - latitude1) * Math.PI/180;
        Decimal longitudeDelta = (longitude2 - longitude1) * Math.PI/180;
        Decimal a = Math.sin(latitudeDelta/2) * Math.sin(latitudeDelta/2) +
        Math.cos(latitudeRadians1) * Math.cos(latitudeRadians2) *
        Math.sin(longitudeDelta/2) * Math.sin(longitudeDelta/2);
        Decimal arc = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        Decimal distance = earthRadius * arc; // in metres

        return distance;
    }
}
