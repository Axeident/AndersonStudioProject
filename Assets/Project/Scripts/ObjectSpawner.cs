using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectSpawner : MonoBehaviour
{
    public List<GameObject> SpawnPool;


    void Awake()
    {
        if (SpawnPool.Count > 0)
        {
            int selection = Random.Range(0, SpawnPool.Count);

            Instantiate(SpawnPool[selection], transform);
        }
    }
}
