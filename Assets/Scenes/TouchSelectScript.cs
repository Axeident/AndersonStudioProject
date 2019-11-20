using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TouchSelectScript : MonoBehaviour
{
    // used to make sure that triggers do not continue after scene has been completed
    private bool runningScript;
    private List<Transform> trigs;

    public GameObject parent;

    // Start is called before the first frame update
    void Awake()
    {
        runningScript = true;
        trigs = new List<Transform>();
        foreach(Transform getTrig in transform)
        {
            if(getTrig.CompareTag("TriggerOne") || getTrig.CompareTag("TriggerTwo"))
            {
                trigs.Add(getTrig);
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (runningScript)
        {
            if (other.CompareTag("TriggerOne"))
            {

                //GetComponentInParent<TouchScript>().selectionMade(0);
                parent.GetComponent<TouchScript>().selectionMade(0);


                this.gameObject.SetActive(false);

                //disable touch movement on the objects in the scene
                foreach(Transform trigOff in trigs)
                {
                    //trigOff.GetComponent<GrabbableRespawn>().enabled = false;
                    //trigOff.GetComponent<OVRGrabbable>().enabled = false;
                    //Destroy(trigOff.GetComponent<Rigidbody>());
                    trigOff.gameObject.SetActive(false);
                }

                //Deactivate the script, so it doesn't cause strange issues later on in the engine.
                runningScript = false;
                
            }
            if (other.CompareTag("TriggerTwo"))
            {
                
                //GetComponentInParent<TouchScript>().selectionMade(1);
                parent.GetComponent<TouchScript>().selectionMade(1);


                this.gameObject.SetActive(false);

                //disable touch movement on the objects in the scene
                foreach (Transform trigOff in trigs)
                {
                    //trigOff.GetComponent<GrabbableRespawn>().enabled = false;
                    //trigOff.GetComponent<OVRGrabbable>().enabled = false;
                    //Destroy(trigOff.GetComponent<Rigidbody>());
                    trigOff.gameObject.SetActive(false);
                }

                //Deactivate the script, so it doesn't cause strange issues later on in the engine.
                runningScript = false;
            }
        }
    }
    
}
