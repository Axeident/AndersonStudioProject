using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TouchScript : MonoBehaviour
{
    // List of gameobjects for possible outcomes
    public List<GameObject> LeadsTo;
    // List of trigger items
    private List<Transform> triggers;
    

    public void selectionMade(int optionChosen)
    {
        
        //Make next scene activation based on choice made/trigger looked at. Should only be 2 options, if more are added,
        //will need to add more trigger tags as well. Fairly simple to do.
        LeadsTo[optionChosen].SetActive(true);
        
        foreach (Transform child in transform)
        {
            if (child.gameObject.GetComponent<GrabbableRespawn>())
            {
                child.gameObject.GetComponent<GrabbableRespawn>().respawning = false;
            }
        }

    }
    
}
