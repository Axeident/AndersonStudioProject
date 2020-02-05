using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class QuitandStart : MonoBehaviour
{
    private Transform player;
    RaycastHit hit;

    void Update()
    {
        if (Physics.Raycast(player.position, player.TransformDirection(Vector3.forward), out hit, Mathf.Infinity))
        {
            if (hit.transform.gameObject.CompareTag("TriggerQuit")) // have an object in this tag
            {
                Application.Quit();
            }
            if (hit.transform.gameObject.CompareTag("TriggerStart"))// have an object with this tag
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
            }
        }
    }
}