using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TouchSelectScript : MonoBehaviour
{
    // used to make sure that triggers do not continue after scene has been completed
    private bool runningScript;

    public GameObject parent;

    // Start is called before the first frame update
    void Awake()
    {
        runningScript = true;
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
                //Deactivate the script, so it doesn't cause strange issues later on in the engine.
                runningScript = false;
            }
            if (other.CompareTag("TriggerTwo"))
            {
                
                //GetComponentInParent<TouchScript>().selectionMade(1);
                parent.GetComponent<TouchScript>().selectionMade(1);


                this.gameObject.SetActive(false);
                //Deactivate the script, so it doesn't cause strange issues later on in the engine.
                runningScript = false;
            }
        }
    }
    
}
